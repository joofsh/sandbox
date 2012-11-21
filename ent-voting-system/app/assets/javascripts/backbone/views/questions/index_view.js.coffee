EntVotingSystem.Views.Questions ||= {}

class EntVotingSystem.Views.Questions.IndexView extends Backbone.View
  template: JST["backbone/templates/questions/index"]

  initialize: () ->
    @options.questions.bind('reset', @addAll)

  addAll: () =>
    @options.questions.each(@addOne)

  addOne: (question) =>
    view = new EntVotingSystem.Views.Questions.QuestionView({model : question})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(questions: @options.questions.toJSON() ))
    @addAll()

    return this
