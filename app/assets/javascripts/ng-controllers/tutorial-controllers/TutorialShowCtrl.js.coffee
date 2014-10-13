angular.module('Pomegranate').controller 'TutorialShowCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

    NProgress.start()
    $http.get($location.absUrl() + "/steps").success (data) ->
        renderStep(data)

    renderStep = (data)->
        $scope.test = data.spec.replace(/require (["'])(?:(?=(\\?))\2.)*?\1/, "");
        $scope.instruction = data.instruction
        NProgress.done()
        $scope.stepNumber = data.step_number


    $scope.submitCommand = (event) ->
        NProgress.start()
        $http.post($location.absUrl() + "/test_runner", {source: $scope.source, test: $scope.test, step_number: $scope.stepNumber}).success (data) ->
            $scope.results = data
            NProgress.done()
            $scope.enableProgress = true if !data.exception and data.summary.failure_count is 0

    $scope.goToNextStep = ->
        $scope.enableProgress = false
        NProgress.start()
        $http.get($location.absUrl() + "/steps").success (data) ->
            renderStep(data)


    $scope.editorOptions = {
        lineWrapping : true,
        lineNumbers: true,
        mode: 'text/x-ruby',
        matchBrackets: true,
        indentUnit: 2
    }

]