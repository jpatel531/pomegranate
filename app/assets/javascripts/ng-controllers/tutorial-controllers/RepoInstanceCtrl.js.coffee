angular.module('Pomegranate').controller 'RepoInstanceCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

	userId = (/users\/(\d+)/.exec($location.absUrl())[1])

	newTutorialUrl = "/users/#{userId}/tutorials"

	$scope.createNewTutorial = (repo) ->
		$http.post(newTutorialUrl, {title: $scope.newTutorial.title, description: $scope.newTutorial.description, repo: repo.name}).success (data) ->
			if data.link then window.location = data.link

]