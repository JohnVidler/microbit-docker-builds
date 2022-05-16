#include "MicroBit.h"

extern MicroBit uBit;

void main(){
    while( true )
    {
        uBit.sleep( 1000 );
    }
}