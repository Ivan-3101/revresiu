--query for ui.masterconfig

UPDATE ui.masterconfig SET
configjson = '{
  "tableoptions": [
    {
      "label": "account_monthly",
      "value": "account_monthly",
      "valueLogic": [
        "account",
        "monthly"
      ]
    },
    {
      "label": "account_weekly",
      "value": "account_weekly",
      "valueLogic": [
        "account",
        "weekly"
      ]
    },
    {
      "label": "account",
      "value": "account",
      "valueLogic": [
        "account",
        "daily"
      ]
    },
    {
      "label": "vpa_monthly",
      "value": "vpa_monthly",
      "valueLogic": [
        "vpa",
        "monthly"
      ]
    },
    {
      "label": "vpa",
      "value": "vpa",
      "valueLogic": [
        "vpa",
        "daily"
      ]
    },
    {
      "label": "vpa_weekly",
      "value": "vpa_weekly",
      "valueLogic": [
        "vpa",
        "weekly"
      ]
    }
  ],
  "entityoptions": [
    {
      "label": "Account",
      "value": "account"
    },
    {
      "label": "Vpa",
      "value": "vpa"
    }
  ],
  "durationoptions": [
    {
      "label": "Daily",
      "value": "daily"
    },
    {
      "label": "Monthly",
      "value": "monthly"
    },
    {
      "label": "Weekly",
      "value": "weekly"
    }
  ],
  "scorringAggregationOptions": [
  {
    "name": "Batch",
    "options": [
      {
        "label": "Min",
        "value": "min"
      },
      {
        "label": "Max",
        "value": "max"
      },
      {
        "label": "Sum",
        "value": "sum"
      },
      {
        "label": "Avg",
        "value": "avg"
      }
    ]
  },
  {
    "name": "Realtime",
    "options": [
      {
        "label": "Min",
        "value": {
          "reduce": [
            { "var": "scores" },
            {
              "if": [
                { ">": [{ "var": "current.score" }, { "var": "accumulator" }] },
                { "var": "accumulator" },
                { "var": "current.score" }
              ]
            },
            0
          ]
        }
      },
      {
        "label": "Max",
        "value": {
          "reduce": [
            { "var": "scores" },
            {
              "if": [
                { "<": [{ "var": "current.score" }, { "var": "accumulator" }] },
                { "var": "accumulator" },
                { "var": "current.score" }
              ]
            },
            0
          ]
        }
      },
      {
        "label": "Sum",
        "value": {
          "reduce": [
            { "var": "scores" },
            {
              "+": [{ "var": "current.score" }, { "var": "accumulator" }]
            },
            0
          ]
        }
      }
    ]
  }
]

}'::jsonb WHERE
configname = 'Decision Form Config';