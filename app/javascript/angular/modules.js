import angular from 'angular'
import CreativeQualitiesController from './CreativeQualitiesController'

angular
  .module('c-delta.modules', [])
  .controller('CreativeQualitiesController', CreativeQualitiesController)

angular.module('c-delta.modules').filter('subString', function() {
    return function(str, start, end) {
        if (str != undefined) {
            return str.substr(start, end);
        }
    }
})

angular.module('c-delta.modules').filter('makePositive', function() {
    return function(num) { return Math.abs(num); }
});

angular.module('c-delta.modules').directive('showMore', [function() {
    return {
        restrict: 'AE',
        replace: true,
        scope: {
            text: '=',
            limit:'='
        },

        //template: '<div><p ng-show="largeText"> {{ text | subString :0 :end }}.... <a href="javascript:;" ng-click="showMore()" ng-show="isShowMore">Show More</a><a href="javascript:;" ng-click="showLess()" ng-hide="isShowMore">Show Less </a></p><p ng-hide="largeText">{{ text }}</p></div> ',
        template: '<div> \
        			<p ng-show="largeText"> {{ text | limitTo :200 }}....</p> \
        			<p ng-show="!largeText">{{ text }}</p> \
        			<p class="text-center"><a  href="javascript:;" ng-click="showMore()" ng-show="largeText">read more</a></p> \
        			<p class="text-center"><a  href="javascript:;" ng-click="showLess()" ng-show="!largeText">read less </a></p> \
        			</div> ',

        link: function(scope, iElement, iAttrs) {

            
            scope.end = scope.limit;
            scope.isShowMore = true;
            scope.largeText = true;

            // if (scope.text.length <= scope.limit) {
            //     scope.largeText = false;
            // };

            scope.showMore = function() {
            	console.log('hello')
                scope.end = scope.text.length;
                scope.isShowMore = false;

                scope.largeText = false;
            };

            scope.showLess = function() {
            	scope.largeText = true;
                scope.end = scope.limit;
                scope.isShowMore = true;
            };
        }
    };
}]);


