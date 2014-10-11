angular.module('Pomegranate').controller 'TutorialsNewCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

	userId = (/users\/(\d+)/.exec($location.absUrl())[1])

	reposUrl = "/users/#{userId}/repos"


	$http.get(reposUrl).success (data)->
		$scope.repos = data

	$scope.showOptionsFor = (repo) ->
		if $scope.selectedRepo is repo then ($scope.selectedRepo = false) else ($scope.selectedRepo = repo)


]