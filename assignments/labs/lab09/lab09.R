# %%
students <- data.frame(
    name = character(),
    height = numeric(),
    weight = numeric(),
    id = integer()
)
li_add_student <- function(name, height, weight) {
    new_id = ifelse(nrow(students) == 0, 1, max(students$id) + 1)
    new_student <- data.frame(
        name = name,
        height = height,
        weight = weight,
        id = new_id
    )
    students <<- rbind(students, new_student)
    return(students)
}
# %%
#* @param name your name
#* @post /hello_world
hello_world <- function(name) {
    print(paste("Hello, world!", name))
}

#* @get /students
# GET /students retrieves a list of students as an array of objects.
get_students <- function() {
    return(students)
}

#* @param name student's name
#* @param height student's height
#* @param weight student's weight
#* @post /student
add_student <- function(name, height, weight) {
    li_add_student(name, height, weight)
    return(students)
}

#* @param id student's id
#* @patch /student
patch_student <- function(id, name, height, weight) {
        students[students$id == id, "name"] <- name
        students[students$id == id, "height"] <- height
        students[students$id == id, "weight"] <- weight
        return(students)
}

#* @param id student's id
#* @delete /student
delete_student <- function(id) {
        students <<- students[students$id != id, ]
        return(students)
}

#* @get /plot
#* @serializer png
generate_plot <- function() {
    return(plot(students$height, students$weight, xlab="height", ylab="weight"))
}