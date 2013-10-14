/**
 * Copyright 2013. All rights reserved.
 * Jan Schaedlich
 * Created Oct 14, 2013
 */
package com.janschaedlich.utility.di
{
    import com.janschaedlich.utility.di.error.DependencyAlreadyExistError;
    import com.janschaedlich.utility.di.error.DependencyNotFoundError;
    
    import flash.utils.Dictionary;
    
    import mx.utils.StringUtil;
    
    public class DIContainer
    {
        protected var container:Dictionary;
        
        public function DIContainer()
        {
            container = new Dictionary();
        }
        
        public function set(identifier:String, object:*, shared:Boolean = false):void
        {
            checkDependencyPresence(identifier);
            if (shared && object is Function)
                container[identifier] = object.call(this);
            else
                container[identifier] = object;
        }
        
        public function get(identifier:String):Object
        {
            checkDependencyExistence(identifier);
            var object:Object = null;
            if (container[identifier] is Function)
                object = (container[identifier] as Function).call(this);
            else
                object = container[identifier];
            return object;
        }
        
        public function remove(identifier:String):void
        {
            checkDependencyExistence(identifier);
            delete container[identifier];
        }
        
        private function checkDependencyPresence(dependencyIdentifier:String):void
        {
            if (container[dependencyIdentifier] != null)
                throw new DependencyAlreadyExistError(StringUtil.substitute("Dependency {identifier} already exists!",
                    dependencyIdentifier));
        }
        
        private function checkDependencyExistence(dependencyIdentifier:String):void
        {
            if (container[dependencyIdentifier] == null)
                throw new DependencyNotFoundError(StringUtil.substitute("Dependency {identifier} not found!",
                    dependencyIdentifier));
        }
    }
}
