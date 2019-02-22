<script>
import { Pie } from 'vue-chartjs'

export default {
  extends: Pie,
  props: [
    'chartFullYearData'
  ],
  mounted: function() {
    this.$root.eventBus.$on('open-pie-chart', this.open)
  },
  methods: {
    open: function(count, name, currentMonthDate) {
      this.renderChart({
        labels: name,
        datasets: [
          {
            label: '内訳',
            backgroundColor: [
              "#FF6384",
              "#36A2EB",
              "#FFCE56",
              "#339900",
              "#ff6633",
              "#cc0099"
            ],
            data: count
          }
        ]
      }, {
        title: {
          display: true,
          text: `${currentMonthDate} の内訳`
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
