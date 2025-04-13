#ifndef BLEHandler_h // Prevents double import 
#define BLEHandler_h

#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <BLE2902.h>
#include <string>  // Add this line


#include <Arduino.h>

#define SERVICE_UUID        "0000ffe0-0000-1000-8000-00805f9b34fb"
#define CHARACTERISTIC_UUID_Q "1afd084a-db39-4805-9075-4cde8b10d07a" //unique question id
#define CHARACTERISTIC_UUID_R "0b9e8c81-39d7-4b86-8d34-4c192b6e3926" //unique rating id
#define CHARACTERISTIC_UUID_S "d909a0e1-c07e-44bf-9e71-53028482688d" // unique service id
#define CHARACTERISTIC_UUID_P "c583a5c9-2d3c-4beb-97ea-0996d7a97493" //unique student password id
#define CHARACTERISTIC_UUID_ESP "979d3306-99d7-4084-9e50-79e0eae765f7" //unique ESP id

#define DEVICE_NAME "Hub_1"


//struct that holds recieved data as well as type of data it is (rating or question)
struct DataReceived {
    std::string data;
    std::string source; // "Q" or "R" or "S" or "P" or "E"
};

// Entire class definition shouldn't really be in header file, but this is fine for now.
class BLEHandler {
  private:
    BLEServer* pServer = NULL;
    BLECharacteristic* pCharacteristicR = NULL;
    BLECharacteristic* pCharacteristicQ = NULL;
    BLECharacteristic* pCharacteristicS = NULL;
    BLECharacteristic* pCharacteristicP = NULL; //password
    BLECharacteristic* pCharacteristicESP = NULL; //instructor password
    BLEAdvertising *pAdvertising = NULL;
    
    bool deviceConnected = false;
    bool dataAvailable = false; // Whether data is available
    DataReceived dataReceived; // Store both data and source received 
    
    void startAdvertising() {
        delay(500); // Give the bluetooth stack the chance to get things ready
        pAdvertising->start(); 
        Serial.println("Started Advertising");
    }

    // Callback class for handling device connect/disconnect
    class ServerCallbacks: public BLEServerCallbacks {
      // Give class reference to the encapsulating class so we can use its members
      BLEHandler &outer;
      public:
        ServerCallbacks(BLEHandler &outer_) : outer(outer_) {}
      
      void onConnect(BLEServer* pServer) {
        outer.deviceConnected = true;
        Serial.println("Device Connected");
      };
  
      void onDisconnect(BLEServer* pServer) {
        outer.deviceConnected = false;
        Serial.println("Device Disconnected");
        outer.startAdvertising(); // Restart advertising
      }
    };

    // Callback class for handling incoming data
    class CharacteristicCallbacks: public BLECharacteristicCallbacks { 
      // Give class reference to the encapsulating class so we can use its members
      BLEHandler &outer;
      public:
        CharacteristicCallbacks(BLEHandler &outer_) : outer(outer_) {}
        
      void onWrite(BLECharacteristic *pCharacteristic) { 
        Serial.println("Some data was recieved");
        std::string val = std::string(pCharacteristic->getValue().c_str());
        Serial.print("val:");
        Serial.println(val.c_str());
        // Determine which characteristic the data came from
        if (pCharacteristic->getUUID().toString() == CHARACTERISTIC_UUID_Q) {
            outer.dataReceived.source = "Q"; // It's from characteristic Q
        } else if (pCharacteristic->getUUID().toString() == CHARACTERISTIC_UUID_R) {
            outer.dataReceived.source = "R"; // It's from characteristic R
        } else if (pCharacteristic->getUUID().toString() == CHARACTERISTIC_UUID_S) {
            outer.dataReceived.source = "S"; // It's from characteristic S
        }else if (pCharacteristic->getUUID().toString() == CHARACTERISTIC_UUID_P) {
            outer.dataReceived.source = "P"; // It's from characteristic PS
        }else if (pCharacteristic->getUUID().toString() == CHARACTERISTIC_UUID_ESP) {
            outer.dataReceived.source = "E"; // It's from characteristic PI  
        }
        outer.dataReceived.data = val;
        outer.dataAvailable = true;
        
      }
    };

  public:
    bool isDeviceConnected() {
      return deviceConnected;
    }

    bool isDataAvailable(){
      return dataAvailable;
    }

      DataReceived getData() {
      dataAvailable = false;
      return dataReceived;
    }
    
    void notifyESP(std::string s) {
      Serial.print("Sending ESP notification:");
      Serial.println(s.c_str());
      pCharacteristicESP->setValue(s.c_str());
      pCharacteristicESP->notify();
      Serial.println("Finished Nofity");
    }

   
    void init() { 
      // Create device
      BLEDevice::init(DEVICE_NAME);

      // Create server
      pServer = BLEDevice::createServer();
      pServer->setCallbacks(new ServerCallbacks(*this));

      // Create service
      BLEService *pService = pServer->createService(SERVICE_UUID);
    
      //Q setup
      pCharacteristicQ = pService->createCharacteristic(
                                 CHARACTERISTIC_UUID_Q,
                                 BLECharacteristic::PROPERTY_READ |
                                 BLECharacteristic::PROPERTY_WRITE 
                                 //BLECharacteristic::PROPERTY_NOTIFY |
                                 //BLECharacteristic::PROPERTY_INDICATE
                               );
      pCharacteristicQ->setCallbacks(new CharacteristicCallbacks(*this));
      //R Setup
      pCharacteristicR = pService->createCharacteristic(
                                 CHARACTERISTIC_UUID_R,
                                 BLECharacteristic::PROPERTY_READ |
                                 BLECharacteristic::PROPERTY_WRITE 
                                 //BLECharacteristic::PROPERTY_NOTIFY |
                                 //BLECharacteristic::PROPERTY_INDICATE
                               );
      pCharacteristicR->setCallbacks(new CharacteristicCallbacks(*this));
      //S Setup
      pCharacteristicS = pService->createCharacteristic(
                                 CHARACTERISTIC_UUID_S,
                                 BLECharacteristic::PROPERTY_READ |
                                 BLECharacteristic::PROPERTY_WRITE 
                                 //BLECharacteristic::PROPERTY_NOTIFY |
                                 //BLECharacteristic::PROPERTY_INDICATE
                               );
      pCharacteristicS->setCallbacks(new CharacteristicCallbacks(*this));
      //P Setup
      pCharacteristicP = pService->createCharacteristic(
                                 CHARACTERISTIC_UUID_P,
                                 BLECharacteristic::PROPERTY_READ |
                                 BLECharacteristic::PROPERTY_WRITE 
                                 //BLECharacteristic::PROPERTY_NOTIFY |
                                 //BLECharacteristic::PROPERTY_INDICATE
                               );
      pCharacteristicP->setCallbacks(new CharacteristicCallbacks(*this));

      pCharacteristicESP = pService->createCharacteristic(
                                 CHARACTERISTIC_UUID_ESP,
                                 BLECharacteristic::PROPERTY_READ |
                                 BLECharacteristic::PROPERTY_WRITE |
                                 BLECharacteristic::PROPERTY_NOTIFY
                               );
      pCharacteristicESP->setCallbacks(new CharacteristicCallbacks(*this));
      

      // Create a BLE Descriptor
      pCharacteristicESP->addDescriptor(new BLE2902());
      Serial.print("Created ble2902");
      
  
      pService->start();
      
      pAdvertising = pServer->getAdvertising();
      pAdvertising->addServiceUUID(SERVICE_UUID);
      pAdvertising->setScanResponse(false);
      pAdvertising->setMinPreferred(0x0);
      startAdvertising();
    }
};

#endif