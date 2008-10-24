package com.husky.control.command
{
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.carlcalderon.Debug;
    import com.husky.model.PlayerData;
    
    import flash.display.StageDisplayState;
    /**
     * FullScreenVideoCommand
     * @author iksnae
     * This Command toggles the fullscreen mode..
     */
    public class FullScreenVideoCommand implements ICommand
    {
        private var _model:PlayerData = PlayerData.getInstance()
        public function FullScreenVideoCommand()
        {
        }
        /**
         * toggles the fullscreen mode
         * - checks current mode then sets to opposite
         * @param event
         * @see HuskyData#app
         */
        public function execute(event:CairngormEvent):void
        {
            Debug.log('COMMAND: FullScreenVideoCommand',Debug.YELLOW)
            if(_model.app.stage.displayState == StageDisplayState.NORMAL){
                _model.app.stage.displayState = StageDisplayState.FULL_SCREEN;    
            }else{
                _model.app.stage.displayState = StageDisplayState.NORMAL;       
            }
        }
    }   
}