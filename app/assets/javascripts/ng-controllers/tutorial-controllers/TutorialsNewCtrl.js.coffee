angular.module('Pomegranate').controller 'TutorialsNewCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

	$http.get($location.absUrl().replace('tutorials/new', 'repos')).success (data)->
		$scope.repos = data

	$scope.showOptionsFor = (repo) ->
		if $scope.selectedRepo is repo then ($scope.selectedRepo = false) else ($scope.selectedRepo = repo)


]