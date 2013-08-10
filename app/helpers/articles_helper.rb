module ArticlesHelper
  def published_date(date)
    date.strftime('%B %-d, %Y %l:%M %p UTC')
  end
end
