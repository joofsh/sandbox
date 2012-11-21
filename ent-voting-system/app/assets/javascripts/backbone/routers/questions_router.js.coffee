class EntVotingSystem.Routers.QuestionsRouter extends Backbone.Router
  initialize: (options) ->
    @questions = new EntVotingSystem.Collections.QuestionsCollection()
    @questions.reset options.questions

  routes:
    "new"      : "newQuestion"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"       : "index"

  newQuestion: ->
    @view = new EntVotingSystem.Views.Questions.NewView(collection: @questions)
    $("#questions").html(@view.render().el)

  index: ->
    @view = new EntVotingSystem.Views.Questions.IndexView(questions: @questions)
    $("#questions").html(@view.render().el)

  show: (id) ->
    question = @questions.get(id)

    @view = new EntVotingSystem.Views.Questions.ShowView(model: question)
    $("#questions").html(@view.render().el)

  edit: (id) ->
    question = @questions.get(id)

    @view = new EntVotingSystem.Views.Questions.EditView(model: question)
    $("#questions").html(@view.render().el)
