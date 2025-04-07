#ifndef BLEHandler_h // Prevents double import 
#define BLEHandler_h

#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <BLE2902.h>
#include <string>  // Add this line


#include <Arduino.h>

#define SERVICE_UUID        "0000ffe0-0000-1000-8000-00805f9b34fb"
#define CHARACTERISTIC_UUID_Q "1afd084a-db39-4805-9075-4cde8b10d07a"
#define CHARACTERISTIC_UUID_R "0b9e8c81-39d7-4b86-8d34-4c192b6e3926"
#define CHARACTERISTIC_UUID_S "d909a0e1-c07e-44bf-9e71-53028482688d"

#define DEVICE_NAME "Hub_1"
//struct that holds recieved data as well as type of data it is (rating or question)
struct DataReceived {
    std::string data;
    std::string source; // "Q" or "R" or "S"
};

// Entire class definition shouldn't really be in header file, but this is fine for now.
class BLEHandler {
  private:
    BLEServer* pServer = NULL;
    BLECharacteristic* pCharacteristicR = NULL;
    BLECharacteristic* pCharacteristicQ = NULL;
    BLECharacteristic* pCharacteristicS = NULL;
    BLEAdvertising *pAdvertising = NULL;
    
    bool deviceConnected = false;

    bool dataAvailable = false; // Whether data is available
    //std::string dataReceived; // Actual data that was recieved 
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
        // Determine which characteristic the data came from
        if (pCharacteristic->getUUID().toString() == CHARACTERISTIC_UUID_Q) {
            outer.dataReceived.source = "Q"; // It's from characteristic Q
        } else if (pCharacteristic->getUUID().toString() == CHARACTERISTIC_UUID_R) {
            outer.dataReceived.source = "R"; // It's from characteristic R
        } else if (pCharacteristic->getUUID().toString() == CHARACTERISTIC_UUID_S) {
            outer.dataReceived.source = "S"; // It's from characteristic s
        }
        outer.dataReceived.data = std::string(pCharacteristic->getValue().c_str());
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
    
    void notifyR(std::string s) {
      pCharacteristicR->setValue(s.c_str());
      pCharacteristicR->notify();
    }
    void notifyQ(std::string s) {
      pCharacteristicQ->setValue(s.c_str());
      pCharacteristicQ->notify();
    }
    void notifyS(std::string s) {
      pCharacteristicS->setValue(s.c_str());
      pCharacteristicS->notify();
    }
    void init() {      
      // Create device
      BLEDevice::init(DEVICE_NAME);

      // Create server
      pServer = BLEDevice::createServer();
      pServer->setCallbacks(new ServerCallbacks(*this));

      // Create service
      BLEService *pService = pServer->createService(SERVICE_UUID);
    
      pCharacteristicQ = pService->createCharacteristic(
                                 CHARACTERISTIC_UUID_Q,
                                 BLECharacteristic::PROPERTY_READ |
                                 BLECharacteristic::PROPERTY_WRITE |
                                 BLECharacteristic::PROPERTY_NOTIFY |
                                 BLECharacteristic::PROPERTY_INDICATE
                               );
      pCharacteristicQ->setCallbacks(new CharacteristicCallbacks(*this));

      pCharacteristicR = pService->createCharacteristic(
                                 CHARACTERISTIC_UUID_R,
                                 BLECharacteristic::PROPERTY_READ |
                                 BLECharacteristic::PROPERTY_WRITE |
                                 BLECharacteristic::PROPERTY_NOTIFY |
                                 BLECharacteristic::PROPERTY_INDICATE
                               );
      pCharacteristicR->setCallbacks(new CharacteristicCallbacks(*this));

      pCharacteristicS = pService->createCharacteristic(
                                 CHARACTERISTIC_UUID_S,
                                 BLECharacteristic::PROPERTY_READ |
                                 BLECharacteristic::PROPERTY_WRITE |
                                 BLECharacteristic::PROPERTY_NOTIFY |
                                 BLECharacteristic::PROPERTY_INDICATE
                               );
      pCharacteristicS->setCallbacks(new CharacteristicCallbacks(*this));

      // Create a BLE Descriptor
      pCharacteristicQ->addDescriptor(new BLE2902());
      pCharacteristicR->addDescriptor(new BLE2902());
      pCharacteristicS->addDescriptor(new BLE2902());
  
      pService->start();
      
      pAdvertising = pServer->getAdvertising();
      pAdvertising->addServiceUUID(SERVICE_UUID);
      pAdvertising->setScanResponse(false);
      pAdvertising->setMinPreferred(0x0);
      startAdvertising();
    }
};

#endif