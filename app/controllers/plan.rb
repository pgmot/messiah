# -*- coding: utf-8 -*-
Messiah::App.controllers :plan do
  get '/new' do
    render '/plan/new'
  end

  post '/new' do
    plan = Plan.new
    plan.owner_user = current_user
    plan.start_datetime = DateTime.parse(params[:start_date])
    plan.end_datetime = DateTime.parse(params[:end_date])
    plan.latitude = params[:latitude].to_f
    plan.longitude = params[:longitude].to_f
    plan.save

    redirect "/plan/#{plan.id}"
  end

  get '/:id' do
    @plan = Plan.find_by_id(params[:id])
    render '/plan/detail' unless @plan.nil?
  end

  post '/:id/meshiya' do
    id = params[:id]
    meshiya = params[:meshiya]
    p = Plan.find_by_id(id)
    unless p.nil?
      p.meshiya = meshiya
      p.save
    end
    redirect "/plan/#{id}"
  end

  post '/:id/delete' do
    plan = Plan.find_by_id(params[:id])

    plan.destroy if plan && plan.owner?(current_user)
    redirect '/'
  end


#   post '/:id/attend' do
#     id = params[:id]
#     plan = Plan.find_by_id(id)
#     unless plan.nil?
#       if plan.users.include?(current_user)
#         UserPlan.find_by(plan_id: plan.id, user_id: current_user.id).destroy
#       else
#         up = UserPlan.new
#         up.plan = plan
#         up.user = current_user
#         up.save
#       end
#     end
#     redirect "/plan/#{id}"
#   end

#   post '/:id/comment' do
#     id = params[:id]
#     comment = params[:comment]
#     pc = PlanComment.new
#     pc.plan_id = id
#     pc.user = current_user
#     pc.comment = comment
#     pc.save
#     redirect "/plan/#{id}"
#   end
#
#   get '/:id/delete/confirm' do
#     @id = params[:id]
#     render '/plan/delete_confirm'
#   end
#

end
