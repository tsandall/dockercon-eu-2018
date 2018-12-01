package test_example

test_allow_assignee_positive {
    
    data.acmecorp.authz.allow with input as {
        "method": "GET",
        "path": ["accounts", "alice"],
        "subject": {
            "groups": ["support"],
            "user": "janet",
        }
    } with data.acmecorp.context.tickets as {
        "alice": [
            {"assignee": "janet"},
        ]
    }

}

test_allow_assignee_negative {
    
    not data.acmecorp.authz.allow with input as {
        "method": "GET",
        "path": ["accounts", "alice"],
        "subject": {
            "groups": ["support"],
            "user": "janet",
        }
    } with data.acmecorp.context.tickets as {
        "alice": [
            {"assignee": "bob"},
        ]
    }

}