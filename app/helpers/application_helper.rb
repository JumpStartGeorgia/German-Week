module ApplicationHelper
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def format_time(time)
    time.strftime('%H:%M')
  end
end
