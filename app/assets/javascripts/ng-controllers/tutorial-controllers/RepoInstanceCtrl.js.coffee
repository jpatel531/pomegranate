angular.module('Pomegranate').controller 'RepoInstanceCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

	newTutorialUrl = $location.absUrl().replace "/new", ""

	$scope.createNewTutorial = (repo) ->
		$http.post(newTutorialUrl, {title: $scope.newTutorial.title, description: $scope.newTutorial.description, repo: repo.name}).success (data) ->
			if data.link then window.location = data.link

]