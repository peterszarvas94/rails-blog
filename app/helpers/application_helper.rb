module ApplicationHelper
  def nav_link(text, path)
    if current_page?(path)
      content_tag :span, text, class: "bg-blue-100 dark:bg-blue-900 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-md cursor-default"
    else
      link_to text, path, class: "text-gray-600 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition duration-200 px-3 py-2 rounded-md hover:bg-gray-100 dark:hover:bg-gray-700"
    end
  end
end
