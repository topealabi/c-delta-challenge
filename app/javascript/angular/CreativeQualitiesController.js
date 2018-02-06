function CreativeQualitiesController($scope, $index) {
  $scope.creativeQualities = qualsJSON;
  console.log($scope.creativeQualities);  

	$scope.numLimit=200;
	$scope.expanded=false;
  $scope.readMore = function() {
  	$scope.numLimit=10000;
	$scope.expanded= !$scope.expanded;
    };

    $scope.readLess = function() {
  	$scope.numLimit=200;
	$scope.expanded= !$scope.expanded;
    };
  
}

CreativeQualitiesController.$inject = [
  '$scope',
  '$filter'
]

export default CreativeQualitiesController
