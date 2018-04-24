Vue.component('vote-card', {
  props: ['score'],
  template: "<button type='button' class='btn btn-secondary vote-card col-sm-2'> {{ score }} </button>"
})

var user = new Vue({
  el: '#user',
  data: {
    name:        null,
    room:        null,
    submitted:   false,
    scores:      ['?', 0.5, 1, 2, 3, 5, 8, 13, 20, 40, 100],
    currentTask: {
      id:     'SK-1146',
      scores: [],
      title: 'TITLE HERE'
    },
    tasks: []
  },
  computed: {
    currentTaskLink: function() {
      return "https://jira.skintertainment.com/browse/" + this.currentTask.id
    }
  },
  methods: {
    jiraSubmit: function() {
      //TODO: get http request to work (if may not with jira)
      debugger
      axios.get(this.currentTaskLink)
           .then(function(response) {
             console.log(response);
           })
           .catch(function(error) {
             console.log('error');
             console.log(error);
           })
    },
    roomInfo: function() {
      console.log("name: " + this.name);
      console.log("room: " + this.room);
    },
  }
})

