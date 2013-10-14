/**
 * Copyright 2013. All rights reserved.
 * Jan Schaedlich
 * Created Oct 14, 2013
 */
package com.janschaedlich.utility.di.test
{
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;
    import com.janschaedlich.utility.di.DIContainer;
    
    public class DIContainerTest
    {
        protected var diContainer:DIContainer;
        
        [Before]
        public function setUp():void
        {
            diContainer=new DIContainer();
        }
        
        [After]
        public function tearDown():void
        {
            diContainer=null;
        }
        
        [Test]
        public function testStandardDataType():void
        {
            diContainer.set('value', 100);
            assertEquals(100, diContainer.get('value'));
        }
        
        [Test]
        public function testObject():void
        {
            var number:Number = new Number();
            diContainer.set('object', number);
            assertEquals(number, diContainer.get('object') as Number);
        }
        
        [Test]
        public function testSimpleFunction():void
        {
            var func:Function = function():*
            {
                return 1;
            }
            diContainer.set('simpleFunction', func);
            assertTrue(1, diContainer.get('simpleFunction'));
        }
        
        [Test]
        public function testComplexFunction():void
        {
            var func:Function = function():*
            {
                var object:Object = new Object();
                object.id='TestObject';
                return object;
            }
            diContainer.set('complexFunction', func, false);
            assertTrue('TestObject', diContainer.get('complexFunction').id);
        }
        
        [Test]
        public function testSharedFunction():void
        {
            var generateDate:Function = function():*
            {
                return new Date();
            }
            diContainer.set('date', generateDate, true);
            var dateOne:Date = diContainer.get('date') as Date;
            var dateTwo:Date = diContainer.get('date') as Date;
            assertTrue(dateOne === dateTwo);
        }
        
        [Test(expects="com.janschaedlich.utility.di.error.DependencyNotFoundError")]
        public function testRemoveDependency():void
        {
            var number:Number = new Number();
            diContainer.set('removeDependency', number);
            diContainer.remove('removeDependency');
            diContainer.get('removeDependency');
        }
        
        [Test(expects="com.janschaedlich.utility.di.error.DependencyNotFoundError")]
        public function testRemoveDependencyThrowsError():void
        {
            diContainer.remove('removeDependency');
        }
        
        [Test(expects="com.janschaedlich.utility.di.error.DependencyAlreadyExistError")]
        public function testSetDuplicateDependencyThrowsError():void
        {
            diContainer.set('duplicateDependency', new Number());
            diContainer.set('duplicateDependency', new Number());
        }
    }
}
