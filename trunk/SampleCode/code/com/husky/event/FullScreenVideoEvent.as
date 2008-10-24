package com.husky.event
{
    import com.adobe.cairngorm.control.CairngormEvent;

    public class FullScreenVideoEvent extends CairngormEvent
    {
        static public const EVENT_ID:String='fullScreenVideoEvent';
        public function FullScreenVideoEvent()
        {
            super(EVENT_ID);
        }
        
    }
}