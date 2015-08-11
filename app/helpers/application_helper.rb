module ApplicationHelper
  def my_name
    "Kristoph Matthews"
  end

  def form_group_tag(errors, &block)
     if errors.any?
       content_tag :div, capture(&block), class: 'form-group has-error'
     else
       content_tag :div, capture(&block), class: 'form-group'
     end
  end

  def up_vote_link_classes(post)
    default_class = 'glyphicon glyphicon-chevron-up'
    if current_user.voted(post) && current_user.voted(post).up_vote?
      "#{default_class} voted"
    else
      "#{default_class}"
    end
  end

  def down_vote_link_classes(post)
    default_class = 'glyphicon glyphicon-chevron-down'
    if current_user.voted(post) && current_user.voted(post).down_vote?
      "#{default_class} voted"
    else
      "#{default_class}"
    end
  end

end

#available in views
