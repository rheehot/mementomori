transitionCtrl = [
  '$scope'
  'dataService'
  'd3Service'
  'showService'
  ($scope,dataService,d3Service,showService)->
    showService.toggle('nav',true)
    showService.toggle('amazon',true)

    data30 = data31 = null
    $scope.type = 'rate'

    dataService('30').then (res)->
      data30 = res
      return
    dataService('31').then (res)->
      data31 = res
      setChart(data31)
      return

    chart = null
    setChart = (data)->
      chart = c3.generate {
        bindto: '#chart'
        data: {
          json: data
          keys: {
            x: '年齢'
            value: ['悪性新生物','心疾患','肺炎','脳血管疾患','老衰','不慮の事故','自殺']
          }
          groups: [['年齢','005-009歳','010-014歳','015-019歳','020-024歳','025-029歳','030-034歳','035-039歳','040-044歳','045-049歳','050-054歳','055-059歳','060-064歳','065-069歳','070-074歳','075-079歳','080-084歳','085-089歳','090-094歳','095-099歳','100歳-']]
          type: 'line'
        }
        axis: {
          x: {
            type: 'category'
          }
          y: {
            min: 0
            padding: {
              top:0
              bottom:0
            }
            tick: {
              format: d3.format(',')
            }
          }
        }
        size: {
          height: 400
          width: 720
        }
        padding: {
          bottom: 20
          left: 50
        }
        tooltip: {
          format: {
            value: d3.format(',')
          }
        }
      }
      return
    updateChart = (data)->
      chart.load {
        data: data
      }
      return

    $scope.changeType = (str)->
      if $scope.type != str
        if str == 'number'
          data = data30
        else
          data = data31
        updateChart(data)
        $scope.type = str
      return

    return
]

angular
  .module 'app'
  .controller 'transitionCtrl',transitionCtrl