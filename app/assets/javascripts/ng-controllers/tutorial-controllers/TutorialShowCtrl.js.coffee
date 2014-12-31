angular.module('Pomegranate').controller 'TutorialShowCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

    NProgress.start()
    $http.get($location.absUrl() + "/steps").success (data) ->
        if data.completed_message then ($scope.congratulations = data.completed_message) else renderStep(data)

    renderStep = (data)->
        $scope.test = data.spec.replace(/require (["'])(?:(?=(\\?))\2.)*?\1/, "");
        $scope.source = data.source
        $scope.instruction = data.instruction
        NProgress.done()
        $scope.totalSteps = data.total_steps
        $scope.stepNumber = data.step_number + 1


    $scope.submitCommand = (event) ->
        NProgress.start()
        $http.post($location.absUrl() + "/test_runner", {source: $scope.source, test: $scope.test, step_number: $scope.stepNumber}).success (data) ->
            $scope.results = data
            if data.tutorial_completed
                $scope.tutorialComplete = "Congratulations, you have finished the tutorial!"
                NProgress.done()
            else
                # $scope.results = data
                NProgress.done()
                $scope.enableProgress = true if !data.exception and data.summary.failure_count is 0

    $scope.goToNextStep = ->
        $scope.enableProgress = false
        NProgress.start()
        $http.get($location.absUrl() + "/steps").success (data) ->
            renderStep(data)


    $scope.sourceEditorOptions = {
        lineWrapping : true,
        lineNumbers: true,
        mode: 'text/x-ruby',
        matchBrackets: true,
        indentUnit: 2
    }

    $scope.testEditorOptions = {
        lineWrapping : true,
        lineNumbers: true,
        readOnly: 'nocursor',
        mode: 'text/x-ruby',
        matchBrackets: true,
        indentUnit: 2
    }

]