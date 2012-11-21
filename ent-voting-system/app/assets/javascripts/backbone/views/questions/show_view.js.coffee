EntVotingSystem.Views.Questions ||= {}

class EntVotingSystem.Views.Questions.ShowView extends Backbone.View
  template: JST["backbone/templates/questions/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
