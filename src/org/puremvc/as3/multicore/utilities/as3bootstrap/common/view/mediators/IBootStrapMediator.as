package org.puremvc.as3.multicore.utilities.as3bootstrap.common.view.mediators
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	/**
	 * Interface for Bootstrap mediators
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author krisrange
	 */ 
	public interface IBootStrapMediator 
		extends IProgressMediator
	{
		/** 
		 * Responds to when the Bootstrap startup load has completed. This 
		 * notification is dispatched when all <code>stylesheet</code>, 
		 * <code>font</code>, <code>bitmapFont</code> and 
		 * <code>localization</code> objects in the config XML file have
		 * been loaded.
		 * 
		 * @param notification INotification being passed
		 */
		function respondToBootstrapLoadComplete( $notification:INotification ):void;
		
		/** 
		 * Responds to when the progress data load has completed. This 
		 * notificaion is dispatched when the data progress instance has 
		 * completed. This happens after 
		 * <code>respondToBootstrapLoadComplete()</code>.
		 * 
		 * @param notification INotification being passed
		 */
		function respondToDataLoadComplete( $notification:INotification ):void;
			
		/** 
		 * Responds to when the entire progress load has completed. This is
		 * dispatched when the application progress instance that is stored in
		 * the <code>ProgressProxy</code> has completed. This happens after
		 * <code>respondToDataLoadComplete()</code>
		 * 
		 * @param notification INotification being passed
		 */
		function respondToApplicationLoadComplete( $notification:INotification ):void;
	}
}