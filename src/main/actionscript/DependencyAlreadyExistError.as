/** 
 * Copyright 2013. All rights reserved. 
 * Jan Schaedlich 
 * Created Oct 14, 2013 
 */
package
{
	public class DependencyAlreadyExistError extends Error
	{
		public function DependencyAlreadyExistError(message:String="", id:int=0)
		{
			super(message, id);
		}
	}
}