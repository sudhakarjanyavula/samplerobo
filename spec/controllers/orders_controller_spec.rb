require 'rails_helper'

RSpec.describe Api::Robot::OrdersController do
	let(:robot) {Robot.create}
	let(:params) {{id: robot.id}}
	let(:commands) {{id: robot.id, commands:["PLACE 5,5,EAST", "RIGHT", "MOVE", "LEFT", "MOVE", "RIGHT", "REPORT"]}}
	describe 'Orders' do
		it 'Api sucess Response' do
			post :create, params: commands
			expect(response.status).to eq(200)
		end

		it 'is expected to check for the position' do
			post :create, params: commands
			body = JSON.parse(response.body)
			expect(body["location"]).to eq(["5,4,SOUTH"])
		end
	end
end