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
    redirect '/' unless @plan.owner_user.friend?(current_user)

    render '/plan/detail' unless @plan.nil?
  end

  post '/:id/meshiya' do
    id = params[:id]
    meshiya = params[:meshiya]
    p = Plan.find_by_id(id)
    if p && p.owner?(current_user)
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

  post '/:id/attend' do
    plan = Plan.find_by_id(params[:id])
    redirect '/' unless plan.owner_user.friend?(current_user)

    unless plan.nil?
      if plan.attend_accounts.exists?(current_user)
        plan.attend_accounts.delete(current_user)
      else
        plan.attend_accounts << current_user
      end
    end
    redirect "/plan/#{id}"
  end

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

end
