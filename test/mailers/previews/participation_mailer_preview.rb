# Preview all emails at http://localhost:3000/rails/mailers/participation_mailer
class ParticipationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/participation_mailer/new_participation
  def new_participation
    ParticipationMailer.new_participation
  end

end
