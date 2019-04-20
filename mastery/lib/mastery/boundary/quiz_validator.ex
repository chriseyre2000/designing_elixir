defmodule Mastery.Boundary.QuizValidator do
  import Mastery.Boundary.Validator

  def errors(fields) when is_map(fields) do
    []
    |> require(fields, :title, &validate_title/1)
    |> optional(fields, :mastery, &validate_mastery/1)
  end

  def errors(_fields), do: [{nil, "A map of fields is required"}]

  def validate_title(title) when is_binary(title) do
    check(String.match?(title, ~r{\S}), {:error, "Can't be blank"})
  end

  def validate_title(_title), do: {:error, "Must be a string"}

  def validate_mastery(mastery) when is_integer(mastery) do
    check(mastery > 0, {:error, "Must be greater than zero"})
  end

  def validate_mastery(_mastery), do: {:error, "Musr be an integer"}
end