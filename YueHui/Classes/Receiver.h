//
//  Receiver.h
//  ultrasonicLib
//
//  Created by mac on 12-10-31.
//  Copyright (c) 2012ƒÍ __MyCompanyName__. All rights reserved.
//

#ifndef ultrasonicLib_Receiver_h
#define ultrasonicLib_Receiver_h

//#include "SignalReceiver.h"
#include <string>
using std::string;

class SignalReceiver;

class Receiver {
public:
    Receiver();
    ~Receiver();
    int start();
    int stop();
    int isRunning();
    string getData();
private:
    SignalReceiver* rec;
};

#endif