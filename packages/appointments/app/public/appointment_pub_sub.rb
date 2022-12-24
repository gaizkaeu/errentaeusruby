AppointmentPubSub = PubSubManager.new
AppointmentPubSub.register_event('appointment.created') { appointment_id Integer }
AppointmentPubSub.register_event('appointment.updated') { appointment_id Integer }

AppointmentPubSub.subscribe('appointment.created', AppointmentCreationJob)
AppointmentPubSub.subscribe('appointment.updated', AppointmentUpdateJob)
