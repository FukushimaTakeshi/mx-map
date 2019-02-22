<script>
import { Bar } from 'vue-chartjs'

export default {
  extends: Bar,
  mounted: function() {
    this.$root.eventBus.$on('open-bar-chart', this.open)
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
        onClick: (evt, item) => {
          if (item.length != 0) {
            const year = item[0]['_chart'].options.title.text.slice(0, 4)
            this.$root.eventBus.$emit('week-pie-chart', `${year}/${item[0]['_model'].label}`)
          } else {
            this.$root.eventBus.$emit('default-pie-chart')
          }
        }
      })
    }
  }
}
</script>
