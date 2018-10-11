<script>
import { Bar } from 'vue-chartjs'
import EventBus from '../../packs/users/form.js'

export default {
  extends: Bar,
  props: [
    'chartFullYearData'
  ],
  mounted: function() {
    EventBus.$on('open-bar-chart', this.open)
  },
  methods: {
    open: function(date, count) {
      this.renderChart({
        labels: date,
        datasets: [
          {
            backgroundColor: '#f87979',
            data: count
          }
        ]
      }, {
        title: {
          display: true,
          text: '今月の練習回数'
        },
        scales: {
          yAxes: [{
            display: false,
            ticks: {
              beginAtZero: true
            },
            gridLines: {
              display: false
            }
          }],
          xAxes: [ {
            gridLines: {
              display: false
            }
          }]
        },
        legend: {
          display: false
        },
        responsive: true,
        maintainAspectRatio: false,
        onClick: function (evt, item) {
          if (item.length != 0) {
            const toDay = new Date()
            EventBus.$emit('change-pie-chart', `${toDay.getFullYear()}/${item[0]['_model'].label}`)
          } else {
            EventBus.$emit('change-pie-chart', null)
          }
        }
      })
    }
  }
}
</script>
