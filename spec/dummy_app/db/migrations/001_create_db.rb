# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:posts) do
      primary_key :id
      String :title
      String :description
      Time :created_at
    end

    create_table(:post_comments) do
      primary_key :id
      String :content
      Time :created_at
      foreign_key :post_id, :posts, null: false
    end

    create_table(:artists) do
      primary_key :id
      String :name
      Time :created_at
    end

    create_table(:albums) do
      primary_key :id
      String :name
      Time :created_at
      foreign_key :artist_id, :artists, null: false
    end
  end
end
