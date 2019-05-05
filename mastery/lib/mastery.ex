defmodule Mastery do
  alias Mastery.Boundary.{QuizSession, QuizManager}
  alias Mastery.Boundary.{TemplateValidator, QuizValidator}
  alias Mastery.Core.Quiz

  def build_quiz(fields) do
    with :ok <- QuizValidator.errors(fields),
         :ok <- GenServer.call(QuizManager, {:build_quiz, fields}),
      do: :ok, else: (error -> error)   
  end

  def add_template(title, fields) do
    with :ok <- TemplateValidator.errors(fields),
         :ok <- GenServer.call(QuizManager, {:add_template, title, fields}),
      do: :ok, else: (error -> error)
  end

  def take_quiz(title, email) do
    with %Quiz{} = quiz <- QuizManager.lookup_quiz_by_title(title),
         {:ok, _} <- GenServer.start_link(QuizSession, {quiz, email})
    do
      {title, email}
    else
      error -> error  
    end
  end

  def select_question(name) do
    GenServer.call(name, :select_question)
  end

  def answer_question(name, answer) do
    GenServer.call(name, {:answer_question, answer})
  end
end
