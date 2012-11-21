class EntVotingSystem.Models.Question extends Backbone.Model
  paramRoot: 'question'

  defaults:
    title: null
    body: null
    answer: null

class EntVotingSystem.Collections.QuestionsCollection extends Backbone.Collection
  model: EntVotingSystem.Models.Question
  url: '/questions'
