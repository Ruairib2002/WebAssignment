import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import GpsController from "./controllers/gps_controller"

// Initialize Stimulus application
const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
import "controllers"
