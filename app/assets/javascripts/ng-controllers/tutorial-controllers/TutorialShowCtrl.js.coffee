angular.module('Pomegranate').controller 'TutorialShowCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

    NProgress.start()
    $http.get($location.absUrl() + "/steps").success (data) ->
        $scope.test = data.spec.replace(/require (["'])(?:(?=(\\?))\2.)*?\1/, "");
        $scope.instruction = data.instruction
        NProgress.done()


    $scope.submitCommand = (event) ->
        NProgress.start()
        $http.post($location.absUrl() + "/test_runner", {source: $scope.source, test: $scope.test}).success (data) ->
            $scope.results = data
            NProgress.done()

    $scope.editorOptions = {
        lineWrapping : true,
        lineNumbers: true,
        mode: 'text/x-ruby',
        matchBrackets: true,
        indentUnit: 2
    }

]