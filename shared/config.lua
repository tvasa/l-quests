Config = Config or {}

Config.Ped = {
    model = 'mes_marston5_2_males_01',
    coords = vector4(-1235.34, -1233.57, 79.27, 107.66),
    eye = {
        label = "Job Master",
        icon = "fa-solid fa-user",
        openLabel = "Jobs",
    }
}


Config.Quests = {
    [1] = {
        title = "Food for the Family",
        description = "Howdy, adventurer. I have a little problem. My wife and kids are hungry, and yesterday the animals destroyed our field. All we have left are a few zucchinis, but we need carrots to make at least some pickle. I'd be grateful if you could head to the fields and bring me at least five carrots. It's not far, and I hope it won't take too much of your time. I'll reward you as best I can. So, what do you say, can you help us?",
        drop = {
            {item = 'apple', quantity = 1, chance = 100},
        },
        request = {
            {item = "carrot", quantity = 5},
        }
    },
    [2] = {
        title = "Fruit for the Kids",
        description = "The carrots helped a lot, but now we need something more. Our kids love apples, but we don't have any. Could you please go to the orchard and bring us at least three apples? We'd be really grateful. I'll reward you for your trouble. So, what do you say, can you help us?",
        drop = {
            {item = 'apple', quantity = 1, chance = 100},
        },
        request = {
            {item = "apple", quantity = 3},
        }
    },
    [3] = {
        title = "Firewood for the Stove",
        description = "Hello, adventurer, we have another problem. Our kids are hungry and need something to cook, but we have nothing to heat the stove. Could you please go to the forest and bring us at least five pieces of firewood? We'd be really grateful. I'll reward you as best I can. So, what do you say, can you help us?",
        drop = {
            {item = 'apple', quantity = 1, chance = 100},
        },
        request = {
            {item = "firewood", quantity = 5},
        }
    },
}


