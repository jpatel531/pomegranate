# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

angular.module('Pomegranate').controller 'TutorialsNewCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

	userId = (/users\/(\d+)/.exec($location.absUrl())[1])

	reposUrl = "/users/#{userId}/repos"


	$http.get(reposUrl).success (data)->
		$scope.repos = data

	$scope.showOptionsFor = (repo) ->
		if $scope.selectedRepo is repo then ($scope.selectedRepo = false) else ($scope.selectedRepo = repo)


]

angular.module('Pomegranate').controller 'RepoInstanceCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

	userId = (/users\/(\d+)/.exec($location.absUrl())[1])

	newTutorialUrl = "/users/#{userId}/tutorials"

	$scope.createNewTutorial = (repo) ->
		$http.post(newTutorialUrl, {title: $scope.newTutorial.title, description: $scope.newTutorial.description, repo: repo.name}).success (data) ->
			if data.link then window.location = data.link

]