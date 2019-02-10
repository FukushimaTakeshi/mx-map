<script>
import { Bar } from 'vue-chartjs'
import EventBus from '../../packs/users/form.js'

export default {
  extends: Bar,
  mounted: function() {
    EventBus.$on('open-bar-chart', this.open)
  },
  methods: {
    open: function(date, count, subject) {
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
          text: `${subject}の練習回数`
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
            const year = item[0]['_chart'].options.title.text.slice(0, 4)
            EventBus.$emit('week-pie-chart', `${year}/${item[0]['_model'].label}`)
          } else {
            EventBus.$emit('default-pie-chart')
          }
        }
      })
    }
  }
}
</script>
