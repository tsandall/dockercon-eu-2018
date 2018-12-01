package acmecorp.authz

import data.acmecorp.context.tickets

default allow = false

# Allow users to access their own accounts.
allow = true {
    input.method = "GET"
    input.path = ["accounts", user_name]
    input.subject.user = user_name
}

# Allow support to access assigned accounts.
allow = true {
    input.method = "GET"
    input.path = ["accounts", user_name]
    input.subject.groups[_] = "support"
    input.subject.user = tickets[user_name][_].assignee
}
