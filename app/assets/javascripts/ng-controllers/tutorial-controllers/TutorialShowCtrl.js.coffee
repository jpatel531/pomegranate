angular.module('Pomegranate').controller 'TutorialShowCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

    stepNumber = 0

    NProgress.start()
    $http.get($location.absUrl() + "/steps" + "?step_number=" + stepNumber).success (data) ->
        renderStep(data)

    renderStep = (data)->
        $scope.test = data.spec.replace(/require (["'])(?:(?=(\\?))\2.)*?\1/, "");
        $scope.instruction = data.instruction
        NProgress.done()


    $scope.submitCommand = (event) ->
        NProgress.start()
        $http.post($location.absUrl() + "/test_runner", {source: $scope.source, test: $scope.test}).success (data) ->
            $scope.results = data
            $scope.enableProgress = true if data.summary.failure_count is 0
            NProgress.done()

    $scope.goToNextStep = ->
        stepNumber += 1
        $scope.enableProgress = false
        NProgress.start()
        $http.get($location.absUrl() + "/steps" + "?step_number=" + stepNumber).success (data) ->
            renderStep(data)


    $scope.editorOptions = {
        lineWrapping : true,
        lineNumbers: true,
        mode: 'text/x-ruby',
        matchBrackets: true,
        indentUnit: 2
    }

]