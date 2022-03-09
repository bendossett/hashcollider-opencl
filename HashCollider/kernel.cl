__kernel void vector_add(__global const char** word_list, __global const int word_list_length, __global const int max_word_length, __global const uint32_t* target_hash, int num_words)
{
	int[num_words] global_ids;

  for (int i = 0; i < num_words - 1; i++)
  {
    global_ids[i] = get_global_id(i);
  }

  char[(num_words * max_word_length) + (num_words - 1)] test_string;

  for (int i = 0; i < num_words - 1; i++)
  {
    for (int j = 0; j < max_word_length; j++)
    {
      test_string[(i * max_word_length) + j] = word_list[global_ids[i]][j];
    }
    test_string[(i * max_word_length) + max_word_length] = '_';
  }

  for (int i = 0; i < word_list_length; i++)
  {
    char* last_word = word_list[i];
    for (int j = 0; j < max_word_length; j++)
    {
      test_string[((num_words - 1) * max_word_length) + j] = last_word[j];
    }
    test_string[((num_words - 1) * max_word_length) + max_word_length] = '\0';

    int j = 0;
    uint32_t hash = 0;
    while (test_string[j] != '\0')
    {
      hash += test_string[j++];
      hash += hash << 10;
      hash ^= hash >> 6;
    } 

    hash += hash << 3;
    hash ^= hash >> 11;
    hash += hash << 15;

    if (hash = target_hash)
    {
      printf("%s\n", test_string);
    }
  }
}