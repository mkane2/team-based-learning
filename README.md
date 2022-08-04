# README

A Rails (5.1.2) app for running Team Based Learning quizzes, deployable by one person to Heroku.  Student scores are not visible except to logged-in users, but no guarantees are made about FERPA compliance.  Run at your own risk.

## Deployment instructions
0. Modify the settings in `config/application.rb`
1. Create a [Heroku account](https://signup.heroku.com/)
2. [Create a new app](https://dashboard.heroku.com/new-app)
3. Deploy using [Heroku git](https://dashboard.heroku.com/apps/team-based-learning/deploy/heroku-git)
4. CLI `heroku run rake db:migrate`

## Steps for running a course the first time
1. Login with the email and password from `config/application.rb`
2. Change your password in `/users/edit`
3. Create a new course
4. Create or import the number of teams your course requires
5. Create or import a quiz
6. Create or import questions for your quizzes
7. Import a list of your students or give your students instructions to create their own accounts

## Contributing
Pull requests are very welcome!
