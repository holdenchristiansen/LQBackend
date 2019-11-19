module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, '#', class:"remove_recipe", :onclick => 'remove_fields(this)')
  end

  def link_to_add_fields(name, f, association, locals={})
    new_object = f.object.class.reflect_on_association(association).klass.new

    fields = f.fields_for(association, new_object,
                          :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", locals.merge!(:f => builder))
    end

    link_to(name, "#", :class => "dynamic_add", 'data-association' => "#{association}",
            'data-content' => "#{fields}")
  end
end
