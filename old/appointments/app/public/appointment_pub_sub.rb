AppointmentPubSub = PubSubManager.new
AppointmentPubSub.register_event('appointment.created') { appointment_id String }
AppointmentPubSub.register_event('appointment.updated') { appointment_id String }

AppointmentPubSub.subscribe('appointment.created', AppointmentCreationJob)
AppointmentPubSub.subscribe('appointment.updated', AppointmentUpdateJob)
