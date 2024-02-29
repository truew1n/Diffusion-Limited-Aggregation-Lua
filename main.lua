_G.love = require("love")

function love.load()
    particles = {}
    particle_amount = 1000

    active_particles = {}
    active_particle_amount = 1

    screen_width, screen_height = love.graphics.getDimensions()

    math.randomseed(os.time())

    active_particles[active_particle_amount] = {
        x = math.floor(screen_width / 2),
        y = math.floor(screen_height / 2),
    }

    for i = 1, particle_amount, 1 do
        particles[i] = {
            x = math.floor(math.random() * screen_width),
            y = math.floor(math.random() * screen_height),
        }
    end
end

function love.update(dt)
    for i = 1, particle_amount do
        if particles[i] then
            local moved_particle = nil

            moved_particle = {
                x = particles[i].x + (math.random(0, 4) - 2),
                y = particles[i].y + (math.random(0, 4) - 2)
            }

            local collision = false
            for j = 1, active_particle_amount do
                local dx = moved_particle.x - active_particles[j].x
                local dy = moved_particle.y - active_particles[j].y
                local distance = dx * dx + dy * dy
                if distance < 100 then
                    collision = true
                    break
                end
            end

            if collision then
                active_particle_amount = active_particle_amount + 1
                active_particles[active_particle_amount] = particles[i]
                table.remove(particles, i)
                particle_amount = particle_amount - 1
            else
                if moved_particle and moved_particle.x >= 0 and moved_particle.x < screen_width and moved_particle.y >= 0 and moved_particle.y < screen_height then
                    particles[i] = moved_particle 
                end
            end
        end
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    for i = 1, particle_amount do
        if particles[i] then
            love.graphics.circle("fill", particles[i].x, particles[i].y, 5)
        end
    end

    love.graphics.setColor(0, 0, 1)
    for j = 1, active_particle_amount do
        if active_particles[j] then
            love.graphics.circle("fill", active_particles[j].x, active_particles[j].y, 5)
        end
    end
end