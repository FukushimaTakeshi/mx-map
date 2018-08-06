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
            label: '練習回数',
            backgroundColor: '#f87979',
            data: count
          }
        ]
      }, {
        scales: {
          yAxes: [{
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
          display: true
        },
        responsive: true,
        maintainAspectRatio: false
      })
    }
  }
}
</script>
