module RisksHelper
  CRITICALITY_COLORS = {
    low:      '#27ae60',
    medium:   '#f39c12',
    high:     '#e67e22',
    critical: '#c0392b'
  }.freeze

  TREND_ICONS = {
    down:   '▼',
    stable: '●',
    up:     '▲'
  }.freeze

  TREND_COLORS = {
    down:   '#27ae60',
    stable: '#f39c12',
    up:     '#c0392b'
  }.freeze

  def risk_score_badge(score, level)
    color = CRITICALITY_COLORS[level]
    content_tag(:span, score,
                style: "background:#{color};color:#fff;padding:2px 7px;border-radius:3px;font-weight:bold;")
  end

  def risk_trend_badge(trend)
    color = TREND_COLORS[trend]
    icon  = TREND_ICONS[trend]
    label = l(:"risk_trend_#{trend}")
    content_tag(:span, "#{icon} #{label}",
                style: "color:#{color};font-weight:bold;")
  end

  def probability_label(value)
    l(:"risk_probability_#{value}")
  end

  def impact_label(value)
    l(:"risk_impact_#{value}")
  end

  def score_matrix_cell_color(p, i)
    score = p * i
    case score
    when 1..4   then '#d5e8d4'
    when 5..9   then '#fff2cc'
    when 10..14 then '#ffe6cc'
    else             '#f8cecc'
    end
  end
end
